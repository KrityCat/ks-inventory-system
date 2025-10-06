import { defineConfig, loadEnv } from 'vite'
import path from 'path'
import createVitePlugins from './vite/plugins'

// https://vitejs.dev/config/
export default defineConfig(({ mode, command }) => {
  const env = loadEnv(mode, process.cwd())
  const { VITE_APP_ENV } = env

  // 构建专用配置
  const buildConfig = command === 'build' ? {
    build: {
      sourcemap: false, // 生产环境关闭 sourcemap
      // minify: 'terser', // 使用更高效的压缩工具
      terserOptions: {
        compress: {
          drop_console: true, // 移除 console
          drop_debugger: true // 移除 debugger
        }
      },
      // rollupOptions: {
      //   output: {
      //     manualChunks(id) {
      //       // 精细化分包策略
      //       if (id.includes('node_modules')) {
      //         if (id.includes('lodash')) {
      //           return 'vendor-lodash'
      //         }
      //         if (id.includes('element-plus')) {
      //           return 'vendor-element'
      //         }
      //         return 'vendor'
      //       }
      //     },
      //     entryFileNames: `assets/[name]-[hash].js`,
      //     chunkFileNames: `assets/[name]-[hash].js`,
      //     assetFileNames: `assets/[name]-[hash].[ext]`
      //   }
      // },
      chunkSizeWarningLimit: 1500, // 提高 chunk 大小警告阈值
      cssCodeSplit: true, // 启用 CSS 代码分割
      target: 'esnext' // 使用最新 ES 标准减少 polyfill
    }
  } : {}


  return {
    // 部署生产环境和开发环境下的URL。
    // 默认情况下，vite 会假设你的应用是被部署在一个域名的根路径上
    // 例如 https://www.ruoyi.vip/。如果应用被部署在一个子路径上，你就需要用这个选项指定这个子路径。例如，如果你的应用被部署在 https://www.ruoyi.vip/admin/，则设置 baseUrl 为 /admin/。
    base: VITE_APP_ENV === 'production' ? '/' : '/',
    plugins: createVitePlugins(env, command === 'build'),
    resolve: {
      // https://cn.vitejs.dev/config/#resolve-alias
      alias: {
        // 设置路径
        '~': path.resolve(__dirname, './'),
        // 设置别名
        '@': path.resolve(__dirname, './src')
      },
      // https://cn.vitejs.dev/config/#resolve-extensions
      extensions: ['.mjs', '.js', '.ts', '.jsx', '.tsx', '.json', '.vue']
    },
    // vite 相关配置
    server: {
      port: 80,
      host: true,
      open: true,
      proxy: {
        // https://cn.vitejs.dev/config/#server-proxy
        '/dev-api': {
          target: 'http://localhost:8035',
          changeOrigin: true,
          rewrite: (p) => p.replace(/^\/dev-api/, '')
        }
      }
    },
    //fix:error:stdin>:7356:1: warning: "@charset" must be the first rule in the file
    css: {
      postcss: {
        plugins: [
          {
            postcssPlugin: 'internal:charset-removal',
            AtRule: {
              charset: (atRule) => {
                if (atRule.name === 'charset') {
                  atRule.remove();
                }
              }
            }
          }
        ]
      },
      // 开启构建缓存
      devSourcemap: false
    },
    // 合并构建配置
    ...buildConfig,
  }
})
