<template>
  <div>
    <svg-icon icon-class="github" @click="goto" />
  </div>
</template>

<script setup>
const url = ref('https://gitee.com/KrityCat/ks-inventory-system');

function goto() {
  window.open(url.value)
}
</script>
