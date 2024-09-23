<script setup>

import { ref } from 'vue'

import RowSpacer from './Row-Spacer.vue'
import CardWrapper from './Card-Wrapper.vue'

defineProps({
    msg: String,
})

const editText = ref('');

const editorAppText = ref({
    titleEditor: 'Редактор текста',
    editTextPlaceholder: 'Введите текст для редактирования',

    clearText: '',

    btnDefault: '—',
    btnUpperCase: 'AG',
    btnLowerCase: 'ag',
    btnPascalCase: 'Ag',
    btnRed: 'Текст красным цветом',
    btnBlue: 'Текст синим цветом',


    btnCount: 'Узнать количество символов',
    btnCountWords: 'Узнать количество слов',
})

const textColor = ref('white');

const textToDefault = () => {
    editText.value = editorAppText.value.clearText;
    isUnderlined.value = false;
    isStrikethrough.value = false;
}

const textToUpperCase = () => {
    editText.value = editText.value.toUpperCase();
}

const textToLowerCase = () => {
    editText.value = editText.value.toLowerCase();
}

const textToPascalCase = () => {
    const arrWords = editText.value.split(' ');
    let result = '';

    for (let i = 0; i < arrWords.length; i++) {
        const word = arrWords[i];
        if (word) {
            result += word.charAt(0).toUpperCase() + word.slice(1).toLowerCase();
        }
        if (i < arrWords.length - 1) {
            result += ' ';
        }
    }

    editText.value = result;
}

const isUnderlined = ref(false);
const isStrikethrough = ref(false);

const textWithUnderline = () => {
    isUnderlined.value = !isUnderlined.value;
}

const textToStrikethrough = () => {
    isStrikethrough.value = !isStrikethrough.value;
}

</script>

<template>
    <RowSpacer>
        <CardWrapper class="card-editor pb-4">
            <!-- Заголовок приложения -->
            <!-- 
            <p class="h3">
                {{ editorAppText.titleEditor }}: <br>
            </p> 
            -->
            <div class="editor-output pb-5">
                <div class="btns-wrap gap-3 my-2 pt-2">
                    <div class="d-flex justify-content-start gap-4">
                        <div class="d-flex align-items-center">
                            <span class="d-inline-block pb-1 pe-2">Регистр</span>
                            <button class="btn btn-default" @click="textToDefault">
                                {{ editorAppText.btnDefault }}
                            </button>
                            <button class="btn btn-uppercase" @click="textToUpperCase">
                                {{ editorAppText.btnUpperCase }}
                            </button>
                            <button class="btn btn-lowercase" @click="textToLowerCase">
                                {{ editorAppText.btnLowerCase }}
                            </button>
                            <button class="btn btn-pascalcase" @click="textToPascalCase">
                                {{ editorAppText.btnPascalCase }}
                            </button>
                        </div>

                        <div class="d-flex align-items-center">
                            <span class="d-inline-block pb-1 pe-2">Декорация</span>
                            <button class="btn btn-default" @click="textToDefault">
                                {{ editorAppText.btnDefault }}
                            </button>
                            <button class="btn btn-uppercase" @click="textWithUnderline">
                                <img src="../assets/underline-img.svg" alt="">
                            </button>
                            <button class="btn btn-lowercase" @click="textToStrikethrough">
                                <img src="../assets/strikethrough-img.svg" alt="">
                            </button>
                        </div>
                    </div>
                </div>
                <input class="editor-output-text" v-bind:placeholder="editorAppText.editTextPlaceholder"
                    :style="{ color: textColor }" v-model="editText"
                    :class="{ 'underline': isUnderlined, 'strikethrough': isStrikethrough }">
            </div>
        </CardWrapper>
    </RowSpacer>
</template>


<style scoped>
.editor-output .editor-output-text {
    border-radius: 8px;
    border: 1px solid rgba(252, 252, 252, 0.5);
    background-color: rgba(252, 252, 252, 0.1);
    min-height: 92px;
    width: 100%;
    padding: 10px 14px 58px 14px;
}

.editor-output .editor-output-text::placeholder {
    color: #FCFCFC;
}

.card-editor {
    border: none;
}

.btns-wrap {
    display: flex;
    justify-content: center;
    flex-direction: column;
    flex-wrap: wrap;
}

.btn.btn-default,
.btn.btn-uppercase,
.btn.btn-lowercase,
.btn.btn-pascalcase {
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: rgba(252, 252, 252, 0.16);
    width: 20px;
    height: 20px;
    color: #FCFCFC;
    border-radius: 0;
    padding: 4px 5px;
    font-size: 11px;
}

.btn.btn-default {
    border-top-left-radius: 3px;
    border-bottom-left-radius: 3px;
}

.btn.btn-pascalcase {
    border-top-right-radius: 3px;
    border-bottom-right-radius: 3px;
}

.btn.btn-read-text {
    color: red;
    background-color: #fff;
}

.btn.btn-blue-text {
    color: blue;
    background-color: #fff;
}

.underline {
    text-decoration: underline;
}

.strikethrough {
    text-decoration: line-through;
}
</style>
