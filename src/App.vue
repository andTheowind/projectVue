<script setup>
import { ref, computed } from 'vue';

import SidebarLinks from './components/SidebarLinksLayout.vue';
import Container from './components/Container-El.vue';

import Counter from './components/sidebar-main/Counter-App.vue';
import Editor from './components/sidebar-main/Editor-App.vue';
import Notes from './components/sidebar-main/Notes-App.vue';
import Weather from './components/sidebar-main/Weather-App.vue';

const visibleComponent = ref(null);

const componentsMap = { Counter, Editor, Notes, Weather };

const currentComponent = computed(() => componentsMap[visibleComponent.value]);

const showComponent = (component) => {
  visibleComponent.value = component;
};
</script>

<template>
  <div class="wrapper">
    <SidebarLinks :activeButton="visibleComponent" @showComponent="showComponent" />
    <Container class="main-container">
      <component :is="currentComponent" v-if="currentComponent" class="app-wrapper" />
    </Container>
  </div>
</template>

<style scoped>
.wrapper {
  display: flex;
  flex-direction: row;
}

.main-container {
  min-width: calc(100% - 221.5px);
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