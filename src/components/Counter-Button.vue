<script>
export default {
    name: "CounterButton",
    emits: ['click']
};
</script>

<template>
    <button class="btn-app" @click="$emit('click')">
        <slot></slot>
    </button>
</template>

<style scoped></style>