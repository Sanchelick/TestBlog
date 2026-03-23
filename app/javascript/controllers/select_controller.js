import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"
import Translations from './i18n/select.json'

export default class extends Controller {
  // We bind the select to tom-select on connect
  connect() {
    new TomSelect(this.element)
  }
}
    
