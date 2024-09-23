<script setup>
// import { ref } from 'vue'

import DFlex from './D-Flex.vue'
import CounterButton from './Counter-Button.vue'
import EditorButton from './Editor-Button.vue'
import NotesButton from './Notes-Button.vue'
import WeatherButton from './Weather-Button.vue'

const emit = defineEmits(['showComponent']);
const props = defineProps(['activeButton']);

const emitShowComponent = (component) => {
    emit('showComponent', component);
};

</script>

<template>
    <div class="header">
        <div class="main-btns">
            <DFlex class="justify-content-start flex-column my-4 pt-2 pb-3">
                <NotesButton :class="{ active: props.activeButton === 'Notes' }" @click="emitShowComponent('Notes')">
                    Заметки
                </NotesButton>
                <EditorButton :class="{ active: props.activeButton === 'Editor' }" @click="emitShowComponent('Editor')">
                    Редактор
                </EditorButton>
                <CounterButton :class="{ active: props.activeButton === 'Counter' }"
                    @click="emitShowComponent('Counter')">
                    Счётчик
                </CounterButton>
                <WeatherButton :class="{ active: props.activeButton === 'Weather' }"
                    @click="emitShowComponent('Weather')">
                    Погода
                </WeatherButton>
            </DFlex>
        </div>
        <div class="d-flex justify-content-center align-items-center">
            <div class="logo">
                <a href="https://github.com/andtheowind" target="_blank">andTheowind</a>
            </div>
            <div class="github">
                <a href="https://github.com/andtheowind" target="_blank">
                    <img src="../assets/git-img.png" alt="">
                </a>
            </div>
        </div>
    </div>
</template>

<style scoped>
.header {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: flex-start;
    padding: 8px 22px;
    background-color: #151515;
}

.header a {
    color: #fcfcfc;
    text-decoration: none;
    font-weight: 500;
}

.active {
    color: rgb(29, 40, 255);
}

.logo {
    padding: 0 10px 0 0;
    will-change: filter;
    transition: filter 300ms;
}

.github {
    padding: 0 10px 0 0;
}


@media (min-width: 1200px) {
    .header {
        padding: 10px 26px 20px 26px;
    }
}
</style>