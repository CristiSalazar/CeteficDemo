import { getNavigateCalledWith } from "lightning/navigation";
import { createElement } from "lwc";
import ProfesionalTile from "c/profesionalTile";

describe("c-profesional-tile", () => {
  afterEach(() => {
    // The jsdom instance is shared across test cases in a single file so reset the DOM
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
  });

  it("DOM renderiza correctamente cosas que dependen de la inicialización", () => {
    // Given
    const element = createElement("c-profesional-tile", {
      is: ProfesionalTile
    });
    element.profesional = {
      Name: "Jacinta",
      Description__c: "Terapia familiar",
      Image_URL__c: "https://www.cetefic.cl/wp-content/uploads/2024/02/2a.jpg",
      schedules__c: "Am, Pm"
    };
    //When
    document.body.appendChild(element);
    //Then

    //Query
    const lightningCardEl = element.shadowRoot.querySelector("lightning-card");
    expect(lightningCardEl).not.toBeNull();
    expect(lightningCardEl.title).toBe("Jacinta");

    //Query img element
    const imgEl = element.shadowRoot.querySelector("img");
    expect(imgEl).not.toBeNull();
    expect(imgEl.src).toBe(
      "https://www.cetefic.cl/wp-content/uploads/2024/02/2a.jpg"
    );
  });
  it("Icono Am se muestra si schedule incluye Am", () => {
    // Given
    const element = createElement("c-profesional-tile", {
      is: ProfesionalTile
    });
    element.profesional = {
      Name: "Jacinta",
      Description__c: "Terapia familiar",
      Image_URL__c: "https://www.cetefic.cl/wp-content/uploads/2024/02/2a.jpg",
      schedules__c: "Am"
    };
    //When
    document.body.appendChild(element);
    //Then

    //Query
    const lightningIconEl = element.shadowRoot.querySelector("lightning-icon");
    expect(lightningIconEl).not.toBeNull();
    expect(lightningIconEl.iconName).toBe("custom:custom3");
  });
  it("Icono Am no se muestra si schedule no incluye Am", () => {
    // Given
    const element = createElement("c-profesional-tile", {
      is: ProfesionalTile
    });
    element.profesional = {
      Name: "Jacinta",
      Description__c: "Terapia familiar",
      Image_URL__c: "https://www.cetefic.cl/wp-content/uploads/2024/02/2a.jpg",
      schedules__c: ""
    };
    //When
    document.body.appendChild(element);
    //Then

    //Query
    const lightningIconEl = element.shadowRoot.querySelector("lightning-icon");
    expect(lightningIconEl).toBeNull();
  });
  it("Ambos iconos se muestran si schedule incluye Am y Pm", () => {
    // Given
    const element = createElement("c-profesional-tile", {
      is: ProfesionalTile
    });
    element.profesional = {
      Name: "Jacinta",
      Description__c: "Terapia familiar",
      Image_URL__c: "https://www.cetefic.cl/wp-content/uploads/2024/02/2a.jpg",
      schedules__c: "Am, Pm"
    };
    //When
    document.body.appendChild(element);
    //Then

    //Query
    const lightningIconEls =
      element.shadowRoot.querySelectorAll("lightning-icon");
    expect(lightningIconEls.length).toBe(2);
    expect(lightningIconEls[0].iconName).toBe("custom:custom3");
    expect(lightningIconEls[1].iconName).toBe("custom:custom10");
  });

  it("Cuando se clickea lightning-button se llama al servicio de navegación", () => {
    //Given - inicializo el componente
    const element = createElement("c-profesional-tile", {
      is: ProfesionalTile
    });
    element.profesional = {
      Id: "7865432",
      Name: "Jacinta",
      Description__c: "Terapia familiar",
      Image_URL__c: "https://www.cetefic.cl/wp-content/uploads/2024/02/2a.jpg",
      schedules__c: ""
    };
    document.body.appendChild(element);

    //When - Clickea el lightning-button
    const lightningButtonEl =
      element.shadowRoot.querySelector("lightning-button");
    lightningButtonEl.click();
    //Then - Se ha llamado al servicio de navegación con la página esperada
    const { pageReference } = getNavigateCalledWith();

    //Verify component called with correct event type and params
    expect(pageReference.type).toBe("standard__recordPage");
    expect(pageReference.attributes.actionName).toBe("view");
    expect(pageReference.attributes.recordId).toBe("7865432");
  });
});
