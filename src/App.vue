<script setup>

import { ref } from 'vue'

import Header from './components/Header-Component.vue'
import Container from './components/Container-El.vue'

import Counter from './components/Counter-App.vue'
import Editor from './components/Editor-App.vue'
import Notes from './components/Notes-App.vue'
import Weather from './components/Weather-App.vue'

const visibleComponent = ref(null);

const showComponent = (component) => {
  visibleComponent.value = component;
  // emit('showComponent', component);
};

</script>

<template>
  <div class="wrapper">
    <Header :activeButton="visibleComponent" @showComponent="showComponent" />
    <Container>
      <Counter v-if="visibleComponent === 'Counter'" class="app-wrapper" />
      <Editor v-if="visibleComponent === 'Editor'" class="app-wrapper" />
      <Notes v-if="visibleComponent === 'Notes'" class="app-wrapper" />
      <Weather v-if="visibleComponent === 'Weather'" class="app-wrapper" />
    </Container>
  </div>
</template>

<style scoped>
.wrapper {
  display: flex;
  flex-direction: row;

}

.app-wrapper {
  animation-name: fadeIn;
  animation-duration: 0.45s;
}

@keyframes fadeIn {
  0% {
    transform: scale(0.75);
    visibility: visible;
  }

  100% {
    transform: scale(1);
  }
}
</style>
