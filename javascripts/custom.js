$(function () {
	/* enable all select2 dropdowns */
	$("select.select2").select2();
	$("select.styledSelect").select2({
	  minimumResultsForSearch: Infinity
	});

	$(".rev__solid-select").each(function(){
		var $this = $(this);
		updateSelectData($this);
	})

	$(".rev__solid-select").change(function(){
		var $this = $(this);
		updateSelectData($this);
	})

});

function updateSelectData(elem){
	var thisVal = elem.val().toLowerCase();
	elem.attr('data',thisVal);
}

function isDefined(obj, level, ...rest) {
	if (obj === undefined) return false
	if (rest.length == 0 && obj.hasOwnProperty(level)) return true
	return isDefined(obj[level], ...rest)
}


$(function () {
	_rev.init();
})

const _rev = {

	/* ***********************************************************
		Init */

	init: function() {

		// this.polyfil.reqFrame();
		// this.browser.get();
		// this.loader.init(); // Dependency: this.browser.is
		// this.markup.init(); // Custom Zenu markup (to avoid CSS rewrites and implement new global patterning)
		// this.debug.init();

		this.form.submit();
		this.plugins.init();

	},

	form: {

		submit: function() {

			$('form').submit(function () {
				/* to prevent submit button from double clicking (http://greatwebguy.com/programming/dom/prevent-double-submit-with-jquery/)  */
				$(':submit', this).click(function () {
					return false;
				});

				/* removing auto formatting (i.e. $,% from fields before submitting), used for autonumeric-min.js */
				var $form = $(this);
				$form.find('[data-format-dollar], [data-format-dollarcent], [data-format-ratio], [data-format-percent]').each(function (i) {
					var self = $(this);
					try {
						var v = self.autoNumeric('get');
						self.autoNumeric('destroy');
						self.val(v);
					} catch (err) {
						console.log("Not an autonumeric field: " + self.attr("name"));
					}
				});
			});

		}

	},

	plugins: {

		init: function() {
			_rev.plugins.autoNumeric();
			_rev.plugins.smartSearch();
		},

		autoNumeric: function() {
			/* for formatting dollar values in form, used for autonumeric-min.js */
			$('[data-format-dollar]').autoNumeric('init', {
				aSign: '$',
				mDec: 0
			});
			$('[data-format-dollarcent]').autoNumeric('init', {
				aSign: '$',
				mDec: 2
			});
			$('[data-format-ratio]').autoNumeric('init', {
				aSign: '%',
				pSign: "s",
				mDec: 0,
				vMax: '200.00'
			});
			$('[data-format-percent]').autoNumeric('init', {
				aSign: '%',
				pSign: "s",
				mDec: 2,
				vMax: '100.00'
			});
		},

		smartSearch: function() {
			var $smartSearch = $('[data-smartsearch]');
			$smartSearch.typeWatch({
				callback: function (value) {
					$.ajax({
						method: 'get',
						url: $smartSearch.attr('data-url'),
						data: {
							q: value
						},
						crossDomain: true
					}).done(function (response) {
						if (response.success == true){
							$('body').addClass('search-open');
							$('.smart-search-results').fadeIn();
							return _rev.xhr.markup.smartSearch(response, $smartSearch);
						}
						// throw new Error(err.responseText || err);
					}).fail(function (err) {
						console.log('failed');
						$('body').removeClass('search-open');
						$('.smart-search-results').fadeOut();
						throw new Error(err.responseText || err);
					})
				},
				wait: 500,
				highlight: true,
				captureLength: 1
			}).on('focus', function (e) {
				$(this).attr({
					placeholder: ''
				});
			}).on('blur', function (e) {
				$(this).attr({
					placeholder: 'Agent, Property, ID'
				});
			});
		}

	},

	xhr: {

		markup: {
			smartSearch: function (e, $input) {
				var $container = $('.smart-search-results .results').empty();
				for (const i in e.data.results) {
					var result = e.data.results[i];
					var row = document.createElement("div");
					var a = document.createElement("a");
					var href = document.createAttribute("href");

					href.value = result.value;
					a.setAttributeNode(href);
					a.innerText = result.label;
					row.append(a);

					$container.append(row);
				}

				$(".smart-search-results .overlay").on('click', function (ev) {
					$container.empty();
					$('body').removeClass('search-open');
					$('.smart-search-results').fadeOut();
				});

				return e;
			}
		}

	},

	ob: {

		isDefined: function() {
			if (obj === undefined) return false
			if (rest.length == 0 && obj.hasOwnProperty(level)) return true
			return isDefined(obj[level], ...rest)
		}

	}

}
