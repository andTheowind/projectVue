<script setup>

import { ref } from 'vue'
import RowSpacer from '/src/components/Row-Spacer.vue'
import CardWrapper from '/src/components/Card-Wrapper.vue'

defineProps({
  msg: String,
})

const counterAppText = {
  titleCounter: 'Счётчик',
  btnCountUp: '+',
  btnCountDown: '-',
  btnCountMultiply: '5',
  btnCountDivide: '5',
  amountCounter: 'Общее количество: ',
}

const counter = ref(0);

const countUp = () => {
  counter.value += 1;
}

const countDown = () => {
  counter.value -= 1;
}

const countMultiplyByFive = () => {
  counter.value *= 5;
}

const countDivideByFive = () => {
  counter.value /= 5;
}


</script>

<template>
  <RowSpacer>
    <CardWrapper class="card-counter">
      <div class="output-wrap">
        <span class="display-2 lh-0">{{ counter }}</span>
      </div>
      <div class="btns-wrap my-2 pb-2">
        <div class="main-btn-wrap">
          <button class="main-btn count-up" v-on:click="countUp">
            {{ counterAppText.btnCountUp }}
          </button>
        </div>
        <div class="main-btn-wrap">
          <button class="main-btn count-down" v-on:click="countDown">
            {{ counterAppText.btnCountDown }}
          </button>
        </div>
        <div class="main-btn-wrap">
          <button class="main-btn count-reset" v-on:click="counter = 0">
            <span class="d-inline-block pb-1">&olarr;</span>
          </button>
        </div>
      </div>
      <div class="btns-wrap my-2 pt-2">
        <div class="main-btn-wrap">
          <button class="main-btn count-multiply" v-on:click="countMultiplyByFive">
            <span class="d-inline-block pb-1">&times;</span>
            {{ counterAppText.btnCountMultiply }}
          </button>
        </div>
        <div class="main-btn-wrap">
          <button class="main-btn count-multiply" v-on:click="countDivideByFive">
            <span class="d-inline-block pb-1">&divide;</span>
            {{ counterAppText.btnCountDivide }}
          </button>
        </div>
      </div>
    </CardWrapper>
  </RowSpacer>
</template>

<style scoped>
.card-counter {
  border: none;
}

.output-wrap {
  margin-bottom: 24px;
}

.btns-wrap {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
  padding-top: 35px;
  padding-bottom: 35px;
  gap: 55px;
}

.main-btn-wrap {
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 50%;
  border: 2px solid rgba(252, 252, 252, 0.16);
  padding: 20px;
}

.main-btn.count-up,
.main-btn.count-down,
.main-btn.count-multiply,
.main-btn.count-reset {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 8;
  padding: 8px 10px 8px 10px;
  border: 1.2px solid rgb(81, 82, 108);
  background-color: transparent;
  border-radius: 50%;
  border: 2px solid rgb(29, 40, 255);
  color: #FCFCFC;
  min-width: 100px;
  min-height: 100px;
  font-size: 32px;
}
</style>
