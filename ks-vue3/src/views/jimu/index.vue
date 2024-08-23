<template>
    <i-frame :src="openUrl" />
  </template>

  <script>
  import { getToken } from '@/utils/auth'
  import { indexUrl } from '@/api/jimu/jiMuReport'
  import iFrame from "@/components/iFrame/index";

  export default {
    name: 'Jimu',
    components: { iFrame },
    data() {
      return {
        openUrl: ''
      }
    },
    created() {
      indexUrl().then(res => {
        this.openUrl = res + '?token=' + getToken()
      })
    }
  }
  </script>

  <style scoped>

  </style>