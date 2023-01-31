import { LightningElement, api, wire, track } from 'lwc';

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

    getSelectedContactId(event){
        const idFromSearch = event.detail;
        this.selectedContactId = idFromSearch;
        console.log('SE DEBIO EVIAR1', this.selectedContactId);
    }
}