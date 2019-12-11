import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoggedComponent } from './logged.component';
import { HomeComponent } from './home/home.component';
import {PollComponent} from './poll/poll.component';
import {PolleditComponent} from './polledit/polledit.component';


const routes: Routes = [
  {
    path: '',
    component: LoggedComponent,
    children: [
      { path: '', component: HomeComponent },
      { path: 'poll/:id', component: PollComponent },
      { path: 'poll/:id/edit', component: PolleditComponent }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class LoggedRoutingModule { }
