import { LightningElement, api } from 'lwc';

export default class SearchButton extends LightningElement {

    @api recordId;

    handlerSearchContainer(){
        const container = this.template.querySelector("c-search-container");
        container.showSearchContainer();
        console.log('PROBANDO 1');
    }
}