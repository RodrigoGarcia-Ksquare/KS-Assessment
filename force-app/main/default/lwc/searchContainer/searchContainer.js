import { LightningElement,api,track } from 'lwc';

export default class SearchContainer extends LightningElement {

    @track isShowContainer = false;
    @api accountid;

    @api showSearchContainer(){
        this.isShowContainer = true;
        // const container = this.template.querySelector("c-fetch-contacts");
        // container.connectedCallback();
    }

    closeSearchContainer(){
        this.isShowContainer = false;
    }

}