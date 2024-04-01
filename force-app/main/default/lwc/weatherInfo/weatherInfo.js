// weatherComponent.js
import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import getWeatherData from '@salesforce/apex/WeatherAPI.getWeatherData';

// Definir os campos para recuperar do registro atual
const fields = ['Account.BillingCity'];

export default class WeatherComponent extends LightningElement {
    @api recordId;
    temperature;
    description;
    iconUrl;
    city;

    // Wire para buscar o registro atual e o campo BillingCity
    @wire(getRecord, { recordId: '$recordId', fields })
    wiredRecord({ error, data }) {
        if (data) {
            const billingCity = getFieldValue(data, 'Account.BillingCity');
            this.fetchWeatherData(billingCity);
        } else if (error) {
            console.error('Erro ao obter o registro:', JSON.stringify(error));
        }
    }

    // Método para buscar os dados do clima usando o método Apex
    fetchWeatherData(cityName) {
        getWeatherData({ cityName })
            .then(result => {
                const data = JSON.parse(result);
                this.temperature = (data.main.temp - 273.15).toFixed(2); // Convertendo de Kelvin para Celsius
                this.description = data.weather[0].description;
                this.city = cityName;
                const iconCode = data.weather[0].icon;
                this.iconUrl = `https://openweathermap.org/img/wn/${iconCode}.png`;
            })
            .catch(error => {
                console.error('Erro ao obter dados do clima:', error.message);
            });
    }
}