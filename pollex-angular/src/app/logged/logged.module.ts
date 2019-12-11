import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { LoggedRoutingModule } from './logged-routing.module';
import { LoggedComponent } from './logged.component';
import { HomeComponent } from './home/home.component';
import { PollComponent } from './poll/poll.component';
import { PolleditComponent } from './polledit/polledit.component';


@NgModule({
  declarations: [LoggedComponent, HomeComponent, PollComponent, PolleditComponent],
  imports: [
    CommonModule,
    LoggedRoutingModule
  ]
})
export class LoggedModule { }
