import { Controller } from "@hotwired/stimulus"

//const i18n = Translations[document.querySelector('body').dataset.lang]
export default class extends Controller {
    connect() {
	new window.TomSelect(this.element,{
	plugins: {
		remove_button:{
			title:'Remove this item',
		}
	},
	}
			    )
    }
}
