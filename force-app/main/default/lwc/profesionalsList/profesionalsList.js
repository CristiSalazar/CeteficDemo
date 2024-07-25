import { LightningElement, wire } from 'lwc';
import getFilteredProfesionals from '@salesforce/apex/ProfesionalService.getFilteredProfesionals';

export default class ProfesionalsList extends LightningElement {
    searchText = "";
    @wire(getFilteredProfesionals, {searchText : '$searchText'})
    profesionals; 
    handleInputChange(event){
        const searchTextAux = event.target.value;
        if(searchTextAux.length >= 2 || searchTextAux === "" ){
            this.searchText = searchTextAux;
        }
    }
}