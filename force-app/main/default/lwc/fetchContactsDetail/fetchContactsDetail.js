import { LightningElement, api, track, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = [
    'Contact.Name',
    'Contact.Phone',
    'Contact.Email',
];

export default class FetchContactsDetail extends LightningElement {

    @api contactid;

    @wire(getRecord, { recordId: '$contactid', fields: FIELDS }) contact;

    get name() {
        return this.contact.data.fields.Name.value;
    }

    get phone() {
        return this.contact.data.fields.Phone.value;
    }

    get email() {
        return this.contact.data.fields.Email.value;
    }

}