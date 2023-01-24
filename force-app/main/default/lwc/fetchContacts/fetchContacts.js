import { LightningElement, api, wire, track } from 'lwc';
import getContacts from '@salesforce/apex/accountRecords.getContacts';

const columns = [
    { label: 'Name', fieldName: 'Name', type: 'button', typeAttributes: {label: {fieldName: 'Name'}, variant: 'base'} },
    { label: 'E-mail', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
]

export default class FetchContacts extends LightningElement {

    @api accountid;
    @track contactid;

    @track data;
    @track columns = columns;
    @track displayinfo;

    @wire (getContacts,{acctId:'$accountid'}) 
    contactsResult(contactsInfo){
        const {data, error} = contactsInfo;
        if (data) {
            this.data = data;
            console.log(data.length);
        }
        if(error){
            this.data = undefined;
            console.log(error);
        }
    }

    contactSelected(e){
        console.log("Detail", e);
        console.log("Detail", e.detail);
        console.log("Detail", e.detail.row.Id);
        console.log("rows", e.detail.selectedRows);
    }

}