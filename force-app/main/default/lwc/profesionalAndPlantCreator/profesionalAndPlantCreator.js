import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import createProfesionalWithPacient from "@salesforce/apex/ProfesionalService.createProfesionalWithPacient";

export default class ProfesionalAndPlantCreator extends LightningElement {
    profesionalName;
    profesionalSchedule;
    pacientName;

    
    handleProfesionalNameChange(event){
        this.profesionalName = event.target.value;
    }
    handleProfesionalScheduleChange(event){
        this.profesionalSchedule = event.target.value;
    }
    handlePacientNameChange(event){
        this.pacientName = event.target.value;
    }

    handleButtonClick(){
        createProfesionalWithPacient({
            profesionalName: this.profesionalName,
            profesionalSchedule: this.profesionalSchedule,
            pacientName: this.pacientName
        })
        .then(() =>{
            const evt = new ShowToastEvent({
                title:"Succes",
                message: "Professional and pacient created correctly",
                variant: "Success"
            });
            this.dispatchEvent(evt);
        })
        .catch((error) => {
            const evt = new ShowToastEvent({
                title:"Error",
                message: "Error creatring records" + error,
                variant: "error"
            });
            this.dispatchEvent(evt);
        })
    }


}