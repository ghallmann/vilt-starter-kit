<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Opcodes\LogViewer\Facades\LogViewer;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        LogViewer::auth(function ($request) {
            return auth()->check();
            // Return true allows anyone to access the logs in prod env
            // Create your own validation to allow access to specific users
            // Ex: return auth()->check() && $request->user()->role === 'admin';
        });
    }
}
