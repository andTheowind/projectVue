<script setup>

import { ref } from 'vue'
import RowSpacer from './Row-Spacer.vue'
import CardWrapper from './Card-Wrapper.vue'
import SvgAddButton from './SvgAddButton.vue'
import SvgRemoveButton from './SvgRemoveButton.vue'

defineProps({
    msg: String,
})

const notesAppText = {
    titleNotes: 'Список заметок',
    btnAddNote: 'Добавить заметку',
    btnRemoveAllNotes: 'Удалить все заметки',
    btnRemoveLastNote: 'Удалить последнюю',
    inputNotesErrorText: 'Важно заполнить это поле',
    inputNotesPlaceholder: 'Введите текст заметки',
    amountNotes: 'Общее количество заметок: ',
    missingNoteText: 'Заметок нет. Добавьте первую.',
    labelForUpperCaseInput: 'Поставьте галочку, чтобы сделать заметку верхним регистром',
    labelForLowerCaseInput: 'Поставьте галочку, чтобы сделать заметку нижним регистром',
    btnRemoveThisNote: ''
};

const inputNoteCheckedUpper = ref(false);
// Константа для нижнего регистра
// const inputNoteCheckedLower = ref(false);
const notes = ref([]);
const boxShadowInputDefault = ref('0 0 0 0');
const boxShadowInputError = ref('0 0 0 0.25rem #fcfcfc');
const boxShadowInputSuccess = ref('0 0 0 0.25rem blue');
const inputNotesValue = ref('');
const inputNotesError = ref(false);
const boxShadowInput = ref('0 0 0 0');

const addNote = () => {
    if (inputNotesValue.value === '') {
        inputNotesError.value = true;
        boxShadowInput.value = boxShadowInputError.value;
    } else {
        if (inputNoteCheckedUpper.value.checked) {
            textToUpperCaseInput();
        }
        // Условия для функционала с кнопкой для нижнего регистра
        // if (inputNoteCheckedLower.value.checked) {
        //     textToLowerCaseInput();
        // }
        notes.value.push(inputNotesValue.value);
        inputNotesValue.value = '';
        inputNotesError.value = false;
        boxShadowInput.value = boxShadowInputSuccess.value;
    }
}

const removeAllNotes = () => {
    notes.value = [];
    inputNotesValue.value = '';
    inputNotesError.value = false;
    boxShadowInput.value = boxShadowInputDefault.value;
}

const removeNote = (index) => {
    notes.value.splice(index, 1);
}

// Функция для удаления последней заметки
// const removeLastNote = () => {
//     notes.value.pop();
// }

const textToUpperCaseInput = () => {
    inputNotesValue.value = inputNotesValue.value.toUpperCase();
}

// Функция для нижнего регистра 
// const textToLowerCaseInput = () => {
//     inputNotesValue.value = inputNotesValue.value.toLowerCase();
// }

</script>

<template>
    <RowSpacer>
        <CardWrapper class="card-notes">
            <!-- Заголовок приложения -->
            <!-- <div class="notes-list-title">
                {{ notesAppText.titleNotes }}
            </div> -->
            <div class="notes-list-wrap pt-4">
                <div class="form-control pt-4">
                    <input v-bind:placeholder="notesAppText.inputNotesPlaceholder" v-model="inputNotesValue"
                        v-on:keypress.enter="addNote" v-bind:style="{ boxShadow: boxShadowInput }" type="text"
                        class="input-notes" />
                    <div class="text-danger input-notes-error" v-bind:class="{ 'd-block': inputNotesError }"
                        v-if="inputNotesError">
                        {{ notesAppText.inputNotesErrorText }}
                    </div>
                    <div class="checkbox-wrap gap-2 pt-3 pb-2">
                        <input type="checkbox" ref="inputNoteCheckedUpper" class="inputChecked"
                            id="textToUpperCaseInput">
                        <label class="text-white pt-1" for="textToUpperCaseInput">
                            {{ notesAppText.labelForUpperCaseInput }}
                        </label>
                    </div>
                    <!-- Для нижнего регистра -->
                    <!-- 
                    <div class="checkbox-wrap gap-2 pt-0">
                        <input type="checkbox" ref="inputNoteCheckedLower" class="inputChecked"
                            id="textToLowerCaseInput">
                        <label class="text-white pt-1" for="textToLowerCaseInput">
                            {{ notesAppText.labelForLowerCaseInput }}
                        </label>
                    </div> 
                    -->
                    <!-- //Для нижнего регистра -->
                </div>
                <div class="btns-wrap gap-3 my-1 pt-1">
                    <button class="btn btn-primary btn-add-note" v-on:click="addNote">
                        <SvgAddButton />
                        <span>{{ notesAppText.btnAddNote }}</span>
                    </button>
                    <button class="btn btn-primary btn-remove-all" v-on:click="removeAllNotes">
                        <SvgRemoveButton />
                        <span>{{ notesAppText.btnRemoveAllNotes }}</span>
                    </button>
                    <!-- Для удаления последной заметки -->
                    <!-- 
                    <button class="btn btn-primary btn-last-note" v-on:click="removeLastNote">
                        <SvgRemoveButton />
                        <span>{{ notesAppText.btnRemoveLastNote }}</span>
                    </button> 
                    -->
                </div>
                <ul class="notes-list" v-if="notes.length > 0">
                    <li class="notes-item" v-bind:key="index" v-for="(note, index) in notes">
                        <p> {{ index + 1 }}. {{ note }} </p>
                        <button class="btn btn-remove-note text-white pe-0" v-on:click="removeNote(index)">
                            <img src="../assets/btn.-remove.svg" alt="">
                            {{ notesAppText.btnRemoveThisNote }}
                        </button>
                    </li>
                    <hr class="notes-line">
                    <li class="text-start">
                        {{ notesAppText.amountNotes }} {{ notes.length }}
                    </li>
                </ul>
                <div v-if="notes.length === 0">
                    <p class="pt-1 mt-1">{{ notesAppText.missingNoteText }}</p>
                </div>
            </div>
        </CardWrapper>
    </RowSpacer>
</template>

<style scoped>
.card-notes {
    padding-left: 24px;
    padding-right: 24px;
    border: none;
}

.notes-list-title {
    text-align: center;
}

.notes-list-wrap {
    padding-block: 14px 0;
    padding-inline: 8px;
}

.notes-list-wrap .form-control {
    flex-direction: column;
    margin-bottom: 10px;
    padding: 0;
    background-color: transparent;
    margin-bottom: -1px;
    border-radius: 2px;
    border: none;
}

.notes-list-wrap .form-control input.input-notes,
.notes-list-wrap .form-control input[type="text"].input-notes {
    min-height: 74px;
    width: 100%;
    padding: 0 0 34px 12px !important;
    height: 100%;
    border-radius: 8px;
    border: 1px solid rgba(252, 252, 252, 0.5);
    background-color: rgba(252, 252, 252, 0.1);
}

.notes-list-wrap .form-control input.input-notes,
.notes-list-wrap .form-control input.input-notes::placeholder {
    color: #FCFCFC;
}

.notes-list-wrap .form-control input:focus {
    outline: none !important;
}

.notes-list-wrap .btn {
    border-radius: 24px;
}

.notes-list-wrap .btn.btn-remove-note,
.notes-list-wrap .btn.btn-remove-note:focus,
.notes-list-wrap .btn.btn-remove-note:active {
    border: none;
    outline: none;
    box-shadow: none;
}

.notes-list-wrap .form-control>div {
    text-align: left;
}

.notes-list-wrap .inputChecked {
    cursor: pointer;
    width: 14px;
    height: 14px;
}

.notes-list-wrap .btns-wrap,
.notes-list-wrap>div {
    display: flex;
    justify-content: start;
    flex-wrap: wrap;
}

.notes-list-wrap .checkbox-wrap {
    display: flex;
    justify-content: flex-start;
    align-items: center;
    text-align: left;
}

.notes-list-wrap .checkbox-wrap label {
    padding-bottom: .33rem;
    font-size: 13px;
}

.notes-list-wrap .form-control .input-notes-error {
    display: none;
    padding-top: 6px;
}

.notes-list {
    padding-top: 15px;
}

.notes-list .notes-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: transparent;
    border-radius: 5px;
    padding: 4px 16px 4px 16px;
    color: #FCFCFC;
    margin-top: 6px;
}

.notes-list .notes-item p {
    text-align: left;
    padding-right: 6px;
    margin-bottom: 0;
}

.notes-line {
    margin: 1.25rem 0 0.65rem 0;
}

.btn.btn-primary.btn-remove-all,
.btn.btn-primary.btn-last-note {
    background-color: #EC1212;
    border-color: #EC1212;
}

@media (max-width: 1199px) {
    .notes-list-title {
        font-size: calc(1.3rem + .6vw);
    }
}

@media (min-width: 1200px) {
    .notes-list-title {
        font-size: 1.75rem;
    }
}
</style>
