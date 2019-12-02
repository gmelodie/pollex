import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LandingPageComponent } from './landing-page/landing-page.component';
import { IndexComponent } from './index.component';
import { SignupPageComponent } from './signup-page/signup-page.component';
import { IndexRoutingModule } from './index-routing.module';



@NgModule({
  declarations: [LandingPageComponent, IndexComponent, SignupPageComponent],
  imports: [
    CommonModule,
    IndexRoutingModule
  ],
  providers: []
})
export class IndexModule { }
