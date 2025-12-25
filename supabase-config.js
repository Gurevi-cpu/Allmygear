// Supabase Configuration
const SUPABASE_URL = 'https://ezsurtlznvwsncszfckj.supabase.co'
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV6c3VydGx6bnZ3c25jc3pmY2tqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ1NTc2OTQsImV4cCI6MjA4MDEzMzY5NH0.uuqPr1J_K9ChNWYmydsPyQUEDKAxJaiSzl1qU2TAjcc'

// Initialize Supabase client (wait for SDK to load)
let supabase = null

function initSupabase() {
  if (window.supabase && window.supabase.createClient) {
    supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY)
    return true
  }
  return false
}

// Try to initialize immediately
if (!initSupabase()) {
  // If not available, wait for window load
  window.addEventListener('load', () => {
    if (!initSupabase()) {
      console.error('Supabase SDK failed to load')
    }
  })
}
