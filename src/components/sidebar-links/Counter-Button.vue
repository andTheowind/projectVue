<script>
export default {
    name: "CounterButton",
    emits: ['click']
};
</script>

<template>
    <button class="btn-app user-select-none" @click="$emit('click')"> Счетчик<slot></slot></button>
</template>