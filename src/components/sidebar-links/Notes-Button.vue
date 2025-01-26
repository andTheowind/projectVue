<script>
export default {
    name: "CounterButton",
    emits: ['click']
};
</script>

<template>
    <button class="btn-app user-select-none" @click="$emit('click')"> Заметки<slot></slot></button>
</template>