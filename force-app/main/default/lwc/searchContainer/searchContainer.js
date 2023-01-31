import { LightningElement,api,track } from 'lwc';

export default class SearchContainer extends LightningElement {

    @track isShowContainer = false;
    @track showContactDetail = true;
    @track showCreateNewAccount = false;

    @api accountid;

    @api showSearchContainer(){
        this.isShowContainer = true;
        // const container = this.template.querySelector("c-fetch-contacts");
        // container.connectedCallback();
    }

    closeSearchContainer(){
        this.isShowContainer = false;
    }

    showNewContactContainer(){
        this.showContactDetail = false;
        this.showCreateNewAccount = true;
    }

    showContactTable(){
        this.showCreateNewAccount = false;
        this.showContactDetail = true;
    }

}