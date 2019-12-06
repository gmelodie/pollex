import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoggedComponent } from './logged.component';
import { HomeComponent } from './home/home.component';


const routes: Routes = [
  {
    path: '',
    component: LoggedComponent,
    children: [
      { path: '', component: HomeComponent },
      { path: '/poll', component: PollComponent }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class LoggedRoutingModule { }
