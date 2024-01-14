// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";

import '../stylesheets/public/homes';
import '../stylesheets/public/items';
import '../stylesheets/public/customers';
import '../stylesheets/public/chats';
import '../stylesheets/public/orders';

import '../stylesheets/admin/items';
import '../stylesheets/admin/customers';

require("./slick")
require("./tab")
Rails.start()
Turbolinks.start()
ActiveStorage.start()
