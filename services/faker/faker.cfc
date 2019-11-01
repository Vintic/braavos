<cfcomponent output="false">
  
  <cfscript>
    this.address = new address(this);
    this.company = new company(this);
    this.creditcard = new creditcard(this);
    this.internet = new internet(this);
    this.lorem = new lorem(this);
    this.name = new name(this);
    this.phonenumber = new phonenumber(this);

    faker = this;
  </cfscript>

  <cfinclude template="includes/definitions.cfm" />
  <cfinclude template="includes/helpers.cfm" />

</cfcomponent>