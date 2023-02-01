import { LightningElement, api, wire } from 'lwc';
import getContacts from '@salesforce/apex/accountRecords.getContacts';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners } from 'c/pubsub';

const columns = [
    { label: 'Name', fieldName: 'Name', type: 'button', typeAttributes: {label: {fieldName: 'Name'}, variant: 'base'} },
    { label: 'E-mail', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
]

export default class FetchContactsDatatable extends LightningElement {

    @api accountid;
    @api contactid;
    @api selectedcontactid;
    data = [];
    error;
    columns = columns;
    rowLimit = 5;
    rowOffSet = 0;

    selectedContact = false;

    @wire(CurrentPageReference) pageRef;

    connectedCallback(){
        this.loadData();
        registerListener('sendcontact', this.showDetails, this);
    }

    showDetails(data){
        this.selectedContact = true;
        this.selectedcontactid = data;
        console.log('datos',data);

        this.data = [];
        getContacts({ acctId: this.accountid, limitSize: this.rowLimit, offSetCount: this.rowOffSet, cntId: data}).then(result => {
            let updateRecords = [...this.data, ...result];
            this.data = updateRecords;
            this.error = undefined;
        }).catch(error=>{
            this.error = error;
            this.data = undefined;
        })

    }

    //LAZY LOADING LOGIC BEGINS//
    loadData(){
        if (!this.selectedContact) {
            console.log('PROBANDIO load()');
            let contact;
            if(this.selectedcontactid == undefined){
                contact = '';
            }
            console.log('CONTACT ID',contact);
            return getContacts({ acctId: this.accountid, limitSize: this.rowLimit, offSetCount: this.rowOffSet, cntId: contact}).then(result => {
                let updateRecords = [...this.data, ...result];
                this.data = updateRecords;
                this.error = undefined;
            }).catch(error=>{
                this.error = error;
                this.data = undefined;
            })
        }
    }

    loadMoreData(event){
        const currentRecord = this.data;
        const { target } = event;
        target.isLoading = true;

        this.rowOffSet = this.rowOffSet + this.rowLimit;
        this.loadData().then(() => {target.isLoading = false;});
    }
    //LAZY LOADING LOGIC ENDS//

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