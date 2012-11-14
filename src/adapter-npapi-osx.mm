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

#include "adapter-npapi.h"

#include "../npapi/npapi.h"
#include "../npapi/npfunctions.h"

#include <sstream>

#include "debug.h"

@interface AsyncCaller : NSObject
{
  void* pluginInstance_;
  TuioEvent event_;
}

- (id)initWithPluginInstance:(void*)plugin_instance
                andTuioEvent:(TuioEvent)event;

- (void)invoke;

@end

@implementation AsyncCaller

- (id)initWithPluginInstance:(void*)pluginInstance
                andTuioEvent:(TuioEvent)event {
  id res = [super init];

  pluginInstance_ = pluginInstance;
  event_ = event;

  return res;
}

- (void)invoke {
  D("AsyncCaller::invoke");
  [self performSelectorOnMainThread:@selector(invokeJavascript)
                         withObject:nil
                      waitUntilDone:NO];
}

- (void)invokeJavascript {
  D("AsyncCaller::invokeJavascript");

  std::stringstream url;
	url << "javascript:tuio_callback(";
	url << event_.type << ", ";
	url << event_.sid << ", ";
	url << event_.fid << ", ";
	url << event_.x << ", ";
	url << event_.y << ", ";
	url << event_.a << ");";
  D("url: %s", url.str().c_str());

  // TODO: NPN_GetURL((NPP)pluginInstance_, url.str().c_str(), "_self");

  [self release];
}

@end


NPAPIAdapter::NPAPIAdapter(const void* plugin_instance, const char* callback)
  : plugin_instance_(plugin_instance), callback_(callback) {
}

NPAPIAdapter::~NPAPIAdapter() {
}

void NPAPIAdapter::Init() {
}

void NPAPIAdapter::Destroy() {
}

void NPAPIAdapter::Invoke(TuioEvent event) {
  D("NPAPIAdapter::Invoke");

  AsyncCaller* caller = [[AsyncCaller alloc]
                         initWithPluginInstance:(void*)plugin_instance_
                                               andTuioEvent:event];
  [caller invoke];
}