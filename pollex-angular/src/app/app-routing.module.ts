import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';


const routes: Routes = [
  { path: '',  loadChildren: () => import('./index/index.module').then(mod => mod.IndexModule) },
  { path: 'logged',  loadChildren: () => import('./logged/logged.module').then(mod => mod.LoggedModule) }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
