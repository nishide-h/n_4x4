<template>
  <div>
    <h1>
      <span class="badge  badge-info">モード：{{ mode }}</span>
    </h1>
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

