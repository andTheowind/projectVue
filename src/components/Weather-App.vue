<script setup>
import { ref, computed } from 'vue'
import RowEl from './Row-El.vue'

const weatherAppData = ref({
    inputPlaceholder: 'Введите локацию',
    location: '',
    temperature: 0,
    description: '',
    txtCondition: 'Состояние погоды: ',
    btnSearch: 'Найти',
    txtCelsius: '°C',
    windSpeedMs: '',
    moisture: '',
    forecast: [],
    loading: false,
    error: false
});

const searchQuery = ref('');

// Объект с сокращениями дней недели
const daysShort = {
    'понедельник': 'Пн',
    'вторник': 'Вт',
    'среда': 'Ср',
    'четверг': 'Чт',
    'пятница': 'Пт',
    'суббота': 'Сб',
    'воскресенье': 'Вс'
};

// Функция для получения сокращённого дня недели
const getShortDayName = (date) => {
    const fullDay = new Date(date).toLocaleDateString('ru-RU', { weekday: 'long' });
    return daysShort[fullDay.toLowerCase()] || fullDay;
};

const searchWeather = () => {
    weatherAppData.value.loading = true;
    const currentWeatherFetch = fetch(`http://api.weatherapi.com/v1/current.json?key=cbbfc6fd441d4e72ae8175513241109&q=${searchQuery.value}&lang=ru`)
        .then(response => response.json())
        .then(data => {
            weatherAppData.value.location = data.location.name;
            weatherAppData.value.country = data.location.country;
            weatherAppData.value.timeZone = data.location.tz_id;
            weatherAppData.value.temperature = data.current.temp_c;
            weatherAppData.value.feelsLike = data.current.feelslike_c;
            weatherAppData.value.description = data.current.condition.text;
            weatherAppData.value.windSpeedMs = (data.current.wind_kph / 3.6).toFixed(2);
            weatherAppData.value.windDirection = data.current.wind_dir;
            weatherAppData.value.moisture = data.current.humidity;
            weatherAppData.value.error = false;
        })
        .catch(() => {
            weatherAppData.value.error = true;
        });

    const forecastFetch = fetch(`http://api.weatherapi.com/v1/forecast.json?key=cbbfc6fd441d4e72ae8175513241109&q=${searchQuery.value}&days=7&lang=ru`)
        .then(response => response.json())
        .then(data => {
            weatherAppData.value.forecast = data.forecast.forecastday;
            weatherAppData.value.error = false;
        })
        .catch(() => {
            weatherAppData.value.error = true;
        });

    Promise.all([currentWeatherFetch, forecastFetch])
        .finally(() => {
            weatherAppData.value.loading = false;
            searchQuery.value = '';
        });
}

const moistureColor = computed(() => {
    const moisture = weatherAppData.value.moisture;
    if (moisture < 30) {
        return '#ADD8E6';
    } else if (moisture < 70) {
        return '#007BFF';
    } else {
        return '#004080';
    }
});
</script>

<template>
    <RowEl>
        <div class="col-12">
            <div class="card-weather">
                <div class="weather-app flex-wrap gap-3 my-2 py-2">
                    <div class="weather-app-form">
                        <div class="weather-app-input-wrap">
                            <input type="text" class="form-control weather-app-input"
                                v-bind:placeholder="weatherAppData.inputPlaceholder" v-model="searchQuery"
                                @keypress.enter="searchWeather">
                        </div>
                        <div class="weather-app-btn-wrap" style="max-width:56px;">
                            <button type="button" class="weather-app-btn" @click="searchWeather">
                                <!-- {{ weatherAppData.btnSearch }} -->
                            </button>
                        </div>
                    </div>
                    <div class="weather-app-loading" v-if="weatherAppData.loading">
                        <p>Загрузка...</p>
                    </div>
                </div>
            </div>
        </div>
    </RowEl>
    <RowEl
        v-show="!weatherAppData.loading && !weatherAppData.error && weatherAppData.location && weatherAppData.temperature !== 0"
        class="row-weather-cards">
        <div class="col-3">
            <div class="weather-app-output w-100">
                <div class="weather-app-location w-100">
                    <span class="location h4">{{ weatherAppData.location }} </span> <br>
                    <span class="display-2">{{ weatherAppData.temperature }}&deg;</span> <br>
                    <span class="state"> {{ weatherAppData.description }}</span>
                </div>
            </div>
        </div>
        <div class="col-6">
            <div class="weather-app-output">
                <div class="weather-app-condition">
                    <p>Влажность: {{ weatherAppData.moisture }}%</p>
                    <div class="moisture-bar-wrap">
                        <div class="moisture-bar"
                            :style="{ width: weatherAppData.moisture + '%', backgroundColor: moistureColor }"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-3">
            <div class="weather-app-output">
                <div class="weather-app-suntimes" v-if="weatherAppData.forecast.length">
                    <p class="mb-3 pb-3">
                        <span class="d-inline-block pb-2 mb-1">
                            Восход:
                        </span> <br>
                        <span class="fw-normal text-lowercase h3">
                            {{ weatherAppData.forecast[0].astro.sunrise }}
                        </span>
                    </p>
                    <p class="text-white-50">
                        <span class="d-inline-block pb-2 mb-1">
                            Заход солнца:
                        </span> <br>
                        <span class="fw-normal text-lowercase h4">
                            {{ weatherAppData.forecast[0].astro.sunset }}
                        </span>
                    </p>
                </div>
            </div>
        </div>
        <div class="col-3">
            <div class="weather-app-output">
                <div class="weather-app-week">
                    <ul>
                        <li v-for="day in weatherAppData.forecast" :key="day.date">
                            {{ getShortDayName(day.date) }}:
                            {{ day.day.avgtemp_c }}&deg;
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-3">
            <div class="weather-app-output flex-column justify-content-around">
                <div class="weather-app-air-quality pb-3 mb-1">
                    Страна: <br>
                    <div class="h2 pt-2 mt-1">
                        <span> {{ weatherAppData.country }}</span>
                    </div>
                </div>
                <div class="weather-app-condition">
                    Часовой пояс: <br>
                    <div class="h2 pt-2 mt-1">
                        <span>{{ weatherAppData.timeZone }}</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-3">
            <div class="weather-app-output flex-column justify-content-around">
                <div class="weather-app-wind pb-3 mb-1">
                    Скорость ветра <br>
                    <div class="h2 pt-2 mt-1">
                        {{ weatherAppData.windSpeedMs }}
                        <span class="fw-normal">м/с</span>
                    </div>
                </div>
                <div class="weather-app-pressure">
                    Атмосферное давление <br>
                    <div class="h2 pt-2 mt-1">
                        {{ weatherAppData.windSpeedMs }}
                        <span class="fw-normal">м/с</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-3">
            <div class="weather-app-output flex-column justify-content-around">
                <div class="weather-app-feels pb-3 mb-1">
                    По ощущениям <br>
                    <div class="h2 pt-2 mt-1">
                        <span>{{ weatherAppData.feelsLike }}&deg;</span>
                    </div>
                </div>
                <div class="weather-app-direction">
                    Направление <br>
                    <div class="h2 pt-2 mt-1">
                        <span class="fw-normal text-lowercase">{{ weatherAppData.windDirection }}</span>
                    </div>
                </div>
            </div>
        </div>
    </RowEl>
</template>

<style scoped>
.weather-app {
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.weather-app-form,
.weather-app-output {
    display: flex;
    border-radius: 10px;
}

.weather-app-form {
    align-items: center;
}

.weather-app-form>div {
    width: 100%;
}

.weather-app-input {
    border-top: 1px solid rgba(252, 252, 252, 0.38);
    border-bottom: 1px solid rgba(252, 252, 252, 0.38);
    border-left: 1px solid rgba(252, 252, 252, 0.38);
    border-right: 0;
    border-radius: 30px 0 0 30px;
    padding-left: 15px;
    box-shadow: inset 0px 0px 4px 0px rgba(0, 0, 0, 0.25);
    background-color: rgba(252, 252, 252, 0.16);
}

.weather-app-input,
.weather-app-input::placeholder {
    color: #FCFCFC;
    font-size: 17px;
}

.row-weather-cards>div {
    margin-bottom: 26px;
}

.weather-app-loading {
    color: #FCFCFC;
    width: 100px;
    text-align: center;
}

.row-weather-cards>div .weather-app-output {
    justify-content: space-between;
    flex-wrap: wrap;
    width: 100%;
    padding: 16px 24px 16px 24px;
    border-radius: 16px;
    backdrop-filter: blur(24px);
    background: rgba(0, 0, 0, 0.1);
    color: #FCFCFC;
    height: 100%;
    position: relative;
}

.row-weather-cards>div:first-child .weather-app-output {
    backdrop-filter: none;
    background: transparent;
}

.row-weather-cards>div .weather-app-output::before {
    position: absolute;
    content: ' ';
    display: block;
    width: 100%;
    height: 100%;
    border-radius: inherit;
    background-image: linear-gradient(to bottom, rgba(255, 255, 255, .65), rgba(255, 255, 255, 0));
    padding: 1.5px;
    mask: linear-gradient(rgba(255, 255, 255, 1) 0 0) content-box, linear-gradient(rgba(255, 255, 255, 1) 0 0);
    -webkit-mask-composite: xor;
    mask-composite: exclude;
    top: 0;
    left: 0;
    top: 0;
    z-index: -1;
}

.row-weather-cards>div:first-child .weather-app-output::before {
    background-image: none;
    mask: none;
    -webkit-mask-composite: none;
    mask-composite: none;
}

.weather-app-location {
    text-align: center;
}

.weather-app-location span {
    line-height: 72px;
}

.weather-app-location .location {
    font-weight: 500 !important;
}

.weather-app-location .state {
    font-weight: 400 !important;
    font-size: 18px;
}

.weather-app-condition {
    text-transform: lowercase;
    width: 100%;
}

.weather-app-suntimes {
    display: flex;
    flex-direction: column;
    justify-content: space-around;
}

.weather-app-week ul li {
    line-height: 1.6;
    padding-bottom: 7px;
}

.weather-app-week ul li::first-letter {
    text-transform: uppercase;
}

.weather-app-condition::first-letter {
    text-transform: uppercase;
}

.weather-app-input {
    min-height: 46px;
}

.weather-app-btn-wrap {
    background-image: url('../assets/find-img.svg');
    background-repeat: no-repeat;
    background-size: 50% 50%;
    background-position: 50% 50%;
    line-height: 1;
    max-height: 46px;
    border-top-right-radius: 30px;
    border-bottom-right-radius: 30px;
    overflow: hidden;
    border-top: 1px solid rgba(252, 252, 252, 0.38);
    border-bottom: 1px solid rgba(252, 252, 252, 0.38);
    border-right: 1px solid rgba(252, 252, 252, 0.38);
}

.weather-app-wind {
    display: flex;
    flex-direction: column;
    justify-content: space-around;
}

.weather-app-btn {
    background-color: rgba(252, 252, 252, 0.16);
    min-height: 46px;
    min-width: 46px;
    width: 100%;
    height: 100%;
}

.weather-app-moisture {
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.moisture-bar-wrap {
    width: 100%;
    height: 20px;
    background-color: #e0e0e0;
    border-radius: 10px;
    overflow: hidden;
    position: relative;
}

.moisture-bar {
    height: 100%;
    background-color: #007BFF;
    border-radius: 10px;
    transition: width 0.3s ease;
}
</style>
