//
// Copyright (C) 2009-2012  Fajran Iman Rusadi
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#include "adapter.h"

#include "debug.h"

NPAPIAdapter::NPAPIAdapter(const void* plugin_instance, const char* callback)
    : plugin_instance_(plugin_instance), callback_(callback) {
}

NPAPIAdapter::~NPAPIAdapter() {
}

void NPAPIAdapter::Invoke(Event event) {
  D("NPAPIAdapter::Invoke");
}
