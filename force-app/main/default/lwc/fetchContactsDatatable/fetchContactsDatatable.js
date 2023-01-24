import { LightningElement, api } from 'lwc';
import getContacts from '@salesforce/apex/accountRecords.getContacts';

const columns = [
    { label: 'Name', fieldName: 'Name', type: 'button', typeAttributes: {label: {fieldName: 'Name'}, variant: 'base'} },
    { label: 'E-mail', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
]

export default class FetchContactsDatatable extends LightningElement {

    @api accountid;
    @api contactid;
    data = [];
    error;
    columns = columns;
    rowLimit = 5;
    rowOffSet = 0;


    connectedCallback(){
        this.loadData();
    }

    loadData(){
        return getContacts({ acctId: this.accountid, limitSize: this.rowLimit, offSetCount: this.rowOffSet }).then(result => {
            let updateRecords = [...this.data, ...result];
            this.data = updateRecords;
            this.error = undefined;
        }).catch(error=>{
            this.error = error;
            this.data = undefined;
        })
    }

    loadMoreData(event){
        const currentRecord = this.data;
        const { target } = event;
        target.isLoading = true;

        this.rowOffSet = this.rowOffSet + this.rowLimit;
        this.loadData().then(() => {target.isLoading = false;});
    }

    handleSearchedContact(e){
        console.log('datable');
        console.log("Detail", e);
        console.log("Detail", e.detail);
        console.log("Detail", e.detail.row.Id);
        console.log("rows", e.detail.selectedRows);

        var sendContactId = e.detail.row.Id;
        this.dispatchEvent(new CustomEvent('sendcontid', {detail:sendContactId}));
    }
}