-- SQL script to create shared_items table in Supabase
-- Run this in the Supabase SQL Editor

-- Create the shared_items table
CREATE TABLE IF NOT EXISTS shared_items (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  share_code VARCHAR(20) UNIQUE NOT NULL,
  item_id UUID NOT NULL,
  owner_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  item_data JSONB NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  expires_at TIMESTAMPTZ NOT NULL
);

-- Create index for faster lookups by share_code
CREATE INDEX IF NOT EXISTS idx_shared_items_share_code ON shared_items(share_code);

-- Create index for cleanup of expired items
CREATE INDEX IF NOT EXISTS idx_shared_items_expires_at ON shared_items(expires_at);

-- Enable Row Level Security
ALTER TABLE shared_items ENABLE ROW LEVEL SECURITY;

-- Policy: Anyone can read shared items (public access for viewing)
CREATE POLICY "Anyone can view shared items" ON shared_items
  FOR SELECT
  USING (true);

-- Policy: Authenticated users can create share links for their own items
CREATE POLICY "Users can create share links" ON shared_items
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = owner_id);

-- Policy: Users can delete their own share links
CREATE POLICY "Users can delete own share links" ON shared_items
  FOR DELETE
  TO authenticated
  USING (auth.uid() = owner_id);

-- Optional: Create a function to clean up expired share links (run periodically)
CREATE OR REPLACE FUNCTION cleanup_expired_shares()
RETURNS void AS $$
BEGIN
  DELETE FROM shared_items WHERE expires_at < NOW();
END;
$$ LANGUAGE plpgsql;
