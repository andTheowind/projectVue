<script setup>
import { ref } from 'vue'

defineProps({
    msg: String,
})
</script>

<template>
    <svg width="12" height="11" viewBox="0 0 12 11" fill="none" xmlns="http://www.w3.org/2000/svg">
        <rect x="0.5" y="6.5" width="2" height="11" rx="1" transform="rotate(-90 0.5 6.5)" fill="#FCFCFC" />
        <rect x="7" y="11" width="2" height="11" rx="0.999999" transform="rotate(180 7 11)" fill="#FCFCFC" />
    </svg>
</template>

<style scoped></style>