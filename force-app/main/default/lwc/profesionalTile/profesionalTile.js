import { LightningElement, api} from 'lwc';
import { NavigationMixin } from "lightning/navigation";

export default class ProfesionalTile extends NavigationMixin(LightningElement) {
   @api profesional;
   
   get isAm(){
    return this.profesional.schedules__c.includes("Am");
   }
   get isPm(){
    return this.profesional.schedules__c.includes("Pm");
   }
   navigateToRecordViewPage() {
      this[NavigationMixin.Navigate]({
        type: "standard__recordPage",
        attributes: {
          recordId: this.profesional.Id,
          objectApiName: "professional__c", 
          actionName: "view",
        },
      });
    }


}

