import { LightningElement, api, track, wire } from 'lwc';
import searchContacts from '@salesforce/apex/accountRecords.searchContacts';
import { CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pubsub';

export default class ContactSearchContainer extends LightningElement {

    @wire(CurrentPageReference) objpageReference;

    @api accountid;
    @api contactid;

    showContacts;

    @track contactName = '';
    @track contactCollection = [];
    @track data = [];

    keyChangeEvent(e){
        console.log(e.target.value);
        console.log(e.target.value.length);

        if (e.target.value.length >= 3) {
            this.contactName = e.target.value;
            searchContacts({acctId: this.accountid, cntName: this.contactName}).then(result => {
                this.data = [];
                let records = [...this.data, ...result];
                this.data = records;
                if (this.data.length == 1) {
                    this.contactid = this.data[0].Id;
                }
                this.showContacts = true;
            })
        }
        else{ this.data = ''; this.showContacts = false;}

    }

    enterEvent(e){
        const isEnterKey = e.keyCode === 13;
        if(isEnterKey){
            this.searchedContactEvent();
        }
    }

    searchedContactEvent(){
        if (this.showContacts != '') {
            this.showContacts = false;
            this.contactName = '';
            console.log(this.contactid);
            fireEvent(this.objpageReference, 'sendcontact', this.contactid);
            //this.dispatchEvent(new CustomEvent('sendsearchedcontact', {detail: this.contactid}));
        }
    }

}