<script setup>

import { ref } from 'vue'

defineProps({
  msg: String,
})

const counter = ref(0);

const countUp = () => {
  counter.value = counter.value + 1;
  counter.value = counter.value * 10;
  console.log(counter.value); 
} 

const countDown = () => {
  counter.value = counter.value - 1;
}

const countMultiply = () => {
  counter.value = counter.value * 5;
}


</script>

<template>
  <div class="row" id="rowCounter">
    <div class="col-md-auto"></div>
    <div class="col-md-7 card card-counter mx-md-auto text-center"><span class="h3">Кошелёк: {{ counter }}</span>
      <div class="btns-wrap d-flex justify-content-center flex-wrap gap-3 my-2">
        <button class="btn btn-info count-up" v-on:click="countUp">Увеличить</button>
        <button class="btn btn-danger count-down" v-on:click="countDown">Уменьшить</button>
        <button class="btn btn-warning count-multiply" v-on:click="countMultiply">Умножить на 5</button>
      </div>
    </div>
    <div class="col-md-auto"></div>
  </div>
</template>

<style></style>
