<cfoutput>
<cfif images.RecordCount GT 0>
    <div class="modal-popup modal-popup-floorplan">
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
                            <div class="modal-inner-wrapper__pager"><span id="count-floorplan">1</span><span> of 2</span></div>
                        </div>
                    </div>
                </div>
                <div class="floorplan-slider">
                    <img class="image" src="../assets/images/floorplan.jpg">
                    <img class="image" src="../assets/images/floorplan1.jpg">
                </div>

                <div class="floorplan-slider-thumbnails">
                    <img class="image" src="../assets/images/floorplan.jpg">
                    <img class="image" src="../assets/images/floorplan1.jpg"> 
                </div>
            </div>
        </div>
    
    </div>
</cfif>

</cfoutput>