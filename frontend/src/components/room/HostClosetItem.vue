<template>
  <div id="host-closet-items">
    <div v-for="friend in friends" :key="friend.id">
      <img :src="friend.src" alt="">
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'

export default {
  name: 'HostClosetItem',
  setup() {
    const friends= ref([
      {id: 1, src: require('@/assets/shirt.jpg'), name:'김'},
      {id: 2, src: require('@/assets/shirt.jpg'), name:'배'},
      {id: 3, src: require('@/assets/shirt.jpg'), name:'이'},
      {id: 4, src: require('@/assets/shirt.jpg'), name:'최'},
      {id: 5, src: require('@/assets/shirt.jpg'), name:'박'},
    ])
    return {
     friends 
    }
  }
}
</script>

<style scoped>
#host-closet-items {
  height: 550px;
  overflow-y: scroll;
}

img {
  width: 200px;
  height: 200px;
  margin-top: 15px;
}
</style>