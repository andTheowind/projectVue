<script>
export default {
    name: "WeatherButton",
    emits: ['click']
};
</script>

<template>
    <button class="btn-app user-select-none" @click="$emit('click')">
        <slot></slot>
    </button>
</template>

<style scoped></style>