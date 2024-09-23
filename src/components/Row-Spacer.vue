<script>
export default {
    name: "RowWrapper",
};
</script>

<template>
    <div class="row mt-3">
        <div class="col-md-auto"></div>
        <slot></slot>
        <div class="col-md-auto"></div>
    </div>
</template>

<style scoped></style>