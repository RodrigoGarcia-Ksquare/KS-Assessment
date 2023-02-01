import { LightningElement, api, track, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = [
    'Contact.Name',
    'Contact.Phone',
    'Contact.Email',
    'Contact.Picture__c'
];

export default class FetchContactsDetail extends LightningElement {

    @api contactid;

    @track URLpic;
    @track URLcon;

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

    get conurl(){
        this.URLcon = 'https://theksquaregroup100-dev-ed.develop.lightning.force.com/lightning/r/Contact/'+this.contactid+'/view'
        return this.URLcon;
    }

    get picture() {
        this.URLpic = this.contact.data.fields.Picture__c.value;
        this.URLpic = this.URLpic.split('"');
        this.URLpic = 'https://theksquaregroup100-dev-ed.develop.lightning.force.com' + this.URLpic[1];
        return this.URLpic;
    }

}