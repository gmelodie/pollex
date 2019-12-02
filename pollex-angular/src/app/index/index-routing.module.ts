import { RouterModule, Routes } from '@angular/router';
import { NgModule } from '@angular/core';
import { SignupPageComponent } from './signup-page/signup-page.component';
import { LandingPageComponent } from './landing-page/landing-page.component';
import { IndexComponent } from './index.component';

const indexRoutes: Routes = [
  {
    path: '',
    component: IndexComponent,
    children: [
      { path: '', component: LandingPageComponent },
      { path: 'sign-up', component: SignupPageComponent }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(indexRoutes)],
  exports: [RouterModule]
})
export class IndexRoutingModule { }
