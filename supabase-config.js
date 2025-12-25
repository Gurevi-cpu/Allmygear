// Supabase Configuration
const SUPABASE_URL = 'https://ezsurtlznvwsncszfckj.supabase.co'
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV6c3VydGx6bnZ3c25jc3pmY2tqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ1NTc2OTQsImV4cCI6MjA4MDEzMzY5NH0.uuqPr1J_K9ChNWYmydsPyQUEDKAxJaiSzl1qU2TAjcc'

// Initialize Supabase client (wait for SDK to load)
let supabase = null
let initAttempts = 0
const MAX_INIT_ATTEMPTS = 50 // 5 seconds max wait

function initSupabase() {
  if (window.supabase && window.supabase.createClient) {
    supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY)
    console.log('Supabase client initialized')
    return true
  }
  return false
}

// Try to initialize with retries
function tryInitSupabase() {
  if (initSupabase()) {
    return
  }
  
  initAttempts++
  if (initAttempts < MAX_INIT_ATTEMPTS) {
    setTimeout(tryInitSupabase, 100) // Try every 100ms
  } else {
    console.error('Supabase SDK failed to load after 5 seconds')
  }
}

// Start initialization attempts
tryInitSupabase()
