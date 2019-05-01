<template>
  <div>
    <label>モード：{{ mode }}</label>
  </div>
</template>
<script>
  export default {
    name: 'status',
    data() {
      return {
        mode: 'タスク登録'
      }
    }
  }
</script>
<style>
  label {
    color: red;
  }
</style>

