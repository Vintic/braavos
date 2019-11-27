<cfoutput>
<cfif images.RecordCount GT 0>
    <div class="modal-popup modal-popup-photos">
        <div class="modal-overlay"></div>
        <div class="modal-wrapper container">
            <div class="modal-close"></div>
            <div class="modal-inner-wrapper">
                <div class="modal-inner-wrapper__top">
                    <div class="row">
                        <div class="col-1-1 col-tablet-2-3 col-slider-address">
                            <span>#titleise(listing.fullAddress)#</span>
                        </div>
                        <div class="col-1-1 col-tablet-1-3 col-slider-pager">
                            <button data-hook="contact-agency-email" class="button modal-inner-wrapper__contact">Contact Agent</button>
                            <div class="modal-inner-wrapper__pager"><span id="count">1</span><span> of #images.RecordCount#</span></div>
                        </div>
                    </div>
                </div>
                <div class="photo-slider">
                    <cfloop query="images">
                        <img src="#getImageURL(images.fileName, 400)#" border="0" />
                    </cfloop>
                </div>

                <div class="photo-slider-thumbnails">
                     <cfloop query="images">
                        <img src="#getImageURL(images.fileName, 120)#" border="0" />
                    </cfloop>   
                </div>
            </div>
        </div>
    
    </div>
</cfif>

</cfoutput>