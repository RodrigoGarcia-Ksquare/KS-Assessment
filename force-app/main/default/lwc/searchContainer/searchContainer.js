import { LightningElement,api,track } from 'lwc';

export default class SearchContainer extends LightningElement {

    @track isShowContainer = false;
    @api accountid;

    @api showSearchContainer(){
        this.isShowContainer = true;
    }

    closeSearchContainer(){
        this.isShowContainer = false;
    }

}