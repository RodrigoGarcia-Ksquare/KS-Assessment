import { LightningElement, api, wire, track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getContacts from '@salesforce/apex/accountRecords.getContacts';



export default class FetchContacts extends LightningElement {

    @api accountid;
    @api contactid;
    @track selectedContactId;

    @track displayinfo;

    handleSearchedContact(event){
        const idFromSearch = event.detail;
        this.displayinfo = true;
        this.contactid = idFromSearch;
        console.log('padre', this.contactid);
    }

}