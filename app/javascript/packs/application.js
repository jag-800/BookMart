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

import 'public/homes';
import 'public/items';
import 'public/customers';
import 'public/chats';
import 'public/orders';

import 'admin/items';
import 'admin/customers';

require("./slick")

Rails.start()
Turbolinks.start()
ActiveStorage.start()
